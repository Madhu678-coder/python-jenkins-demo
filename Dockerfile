# Step 1: Use an official Python runtime as the base image
FROM python:3.9-slim

# Step 2: Set the working directory in the container
WORKDIR /usr/src/app

# Step 3: Copy the current directory contents into the container at /usr/src/app
COPY . .

# Step 4: Command to run the script when the container starts
CMD ["python", "./your_script_name.py"]
