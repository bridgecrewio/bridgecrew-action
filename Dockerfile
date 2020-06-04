# Container image that runs your code
FROM python:slim

COPY requirements.txt /requirements.txt

# Install checkov
RUN pip install -r /requirements.txt

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY bridgecrew-problem-matcher.json /usr/local/lib/bridgecrew-problem-matcher.json

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
