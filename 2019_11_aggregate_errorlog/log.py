import logging
import logging.config
import os
from datetime import datetime, timedelta
from typing import Dict, List, Tuple, Union

from google.cloud import storage


def configure_logger(
    logdir_path = None, log_filename="app.log", device_id = None
):
    """Configure python logging module"""

    # Use default logging setting
    log_config = {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {
            "simple": {"format": "%(asctime)s - %(name)s - %(levelname)s - %(message)s"}
        },
        "handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "level": "DEBUG",
                "formatter": "simple",
                "stream": "ext://sys.stdout",
            }
        },
        "root": {"level": "INFO", "handlers": ["console"]},
    }

    # Add TimedRotatingFileHandler if log directory provided
    if logdir_path and os.path.isdir(logdir_path):
        handlers = log_config.setdefault("handlers", {})
        handlers["log_file"] = {
            "level": "INFO",
            "class": "logging.handlers.TimedRotatingFileHandler",
            "when": "midnight",
            "formatter": "simple",
            "filename": os.path.join(logdir_path, log_filename or "app.log"),
            "encoding": "utf-8",
        }

        root = log_config.setdefault("root", {})
        root_handlers = root.get("handlers", [])
        if "log_file" not in root_handlers:
            root["handlers"] = root_handlers + ["log_file"]

    logging.config.dictConfig(log_config)


def main():

        
    os.makedirs("logs", exist_ok=True)
    configure_logger(logdir_path="logs")
    logging.getLogger("gcp_log").setLevel(logging.WARNING)

 
    base_dir=os.getcwd()

    #google authetication credentials
    gcs_client = storage.Client.from_service_account_json(base_dir+"/data-science-248716-2351242f28e8.json")
 
    gcs_bucket = gcs_client.get_bucket("flosense-deployment")

    # getting all log files in that folder

    file_list = gcs_bucket.list_blobs(prefix="flosense-deployment-aggregate-logs/test-failure-logs")
    
    # iterating logs and reading error message in log file
    
    for file in file_list:
        
        if file.name.startswith("flosense-deployment-aggregate-logs/test-failure-logs/errors"):
            continue

        file_txt = file.download_as_string()
        encoding = 'utf-8'
        file_line_lists = str(file_txt,encoding).splitlines()
        for line in file_line_lists:
            
            if 'ERROR' in line or'WARNING' in line:
  
                f= open("data_log.log","a") 
                f.write(line+'\n') 
                f.close()  

    st = datetime.today().strftime('%Y-%m-%d-%H:%M:%S')
    gcs_name = "flosense-deployment-aggregate-logs/test-failure-logs/errors {}.log".format(st)
    gcs_blob = gcs_bucket.blob(gcs_name)
    gcs_blob.upload_from_filename(filename=base_dir+"/data_log.log")
    os.remove(base_dir+"/data_log.log")

    


if __name__ == "__main__":

    main()