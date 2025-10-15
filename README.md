# kaiburr-task2-kubernetes
## Task 2 – Kubernetes Deployment for Kaiburr Task API

### 1. Overview

This project extends the Java-based Task API application developed in Task 1 by deploying it on a Kubernetes cluster. The application provides REST API endpoints to create, search, delete, and execute “task” objects. Each task represents a shell command that can be executed inside a Kubernetes pod, while MongoDB stores all task-related data.

---

### 2. Features

* REST API for creating, retrieving, updating, and deleting tasks.
* Integration with MongoDB for task persistence.
* Execution of shell commands inside Kubernetes pods using the Kubernetes Java Client.
* Persistent Volume for MongoDB to retain data across pod restarts.
* NodePort or LoadBalancer service to expose the application externally.

---

### 3. Technologies Used

* Java 17
* Spring Boot 3
* MongoDB
* Docker
* Kubernetes (kubectl / Minikube / Docker Desktop)
* Maven

---

### 4. Prerequisites

Before deploying, ensure the following are installed on your system:

* Docker Desktop (with Kubernetes enabled) or Minikube
* Java 17 or higher
* Maven
* kubectl command-line tool

---

### 5. Building the Application

#### Step 1: Build using Maven

```
mvn -DskipTests clean package
```

#### Step 2: Build Docker Image

```
docker build -t task-api:latest .
```

---

### 6. Kubernetes Deployment

#### Step 1: Apply MongoDB and API manifests

```
kubectl apply -f mongo-pv.yaml
kubectl apply -f mongo.yaml
kubectl apply -f task-api.yaml
```

#### Step 2: Verify resources

```
kubectl get pods
kubectl get svc
kubectl get pvc,pv
```

#### Step 3: Access the API

After deployment, access the REST API from your host machine using:

```
http://localhost:8080/api/tasks
```

---

### 7. API Endpoints

| Method | Endpoint                    | Description                            |
| ------ | --------------------------- | -------------------------------------- |
| GET    | /api/tasks                  | Retrieve all tasks                     |
| PUT    | /api/tasks                  | Create or update a task                |
| DELETE | /api/tasks/{id}             | Delete a task by ID                    |
| GET    | /api/tasks/find?name={name} | Search tasks by name                   |
| PUT    | /api/tasks/{id}/execution   | Execute a task inside a Kubernetes pod |

---

### 8. Execution Flow

1. MongoDB runs in a separate pod with a Persistent Volume.
2. The Task API container connects to MongoDB using environment variables.
3. When /execution is called, the backend creates a temporary BusyBox pod to execute the shell command.
4. The output and timestamps are stored as a TaskExecution object in MongoDB.

---

### 9. Environment Variable

| Variable  | Description                           | Example      |
| --------- | ------------------------------------- | ------------ |
| EXEC_MODE | Defines where the command is executed | local or k8s |

---

### 11. Notes

* MongoDB data is retained even if the pod is deleted, due to PVC binding.
* Application and MongoDB are deployed in separate pods for modularity.
* The manifests used include:

  * mongo.yaml – MongoDB Deployment and Service
  * mongo-pv.yaml – Persistent Volume and Claim for MongoDB
  * task-api.yaml – Task API Deployment and Service

