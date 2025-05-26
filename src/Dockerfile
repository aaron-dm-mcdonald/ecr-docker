FROM public.ecr.aws/lambda/python:3.11

# Copy the function code
COPY app.py /var/task/app.py
COPY requirements.txt /var/task/requirements.txt

# Install any dependencies
RUN pip install -r /var/task/requirements.txt

# Command to run the Lambda function
CMD ["app.lambda_handler"]