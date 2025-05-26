FROM public.ecr.aws/lambda/python:3.11

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy app source
COPY app.py .

# Set the Lambda handler
CMD ["app.lambda_handler"]
