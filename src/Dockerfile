FROM public.ecr.aws/lambda/python:3.9

# Copy requirements and install
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy app code
COPY app.py ./

# Set the CMD to handler (module.function)
CMD ["app.handler"]
