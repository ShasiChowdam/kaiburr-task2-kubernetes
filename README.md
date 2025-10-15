# kaiburr-task2-kubernetes
Overview

This task extends the Java-based REST API application from Task 1 by deploying it on a Kubernetes cluster. The API provides endpoints to create, search, delete, and execute shell command “tasks” stored in MongoDB. In this phase, the application runs inside Kubernetes pods, with MongoDB deployed in a separate pod and connected via environment variables.

Features

REST API endpoints for task management

MongoDB integration for task persistence

Task execution inside Kubernetes pods using the Kubernetes Java Client

Persistent Volume Claim for MongoDB data

NodePort service to access the API from the host machine

Prerequisites

Docker Desktop or Minikube

Kubernetes CLI (kubectl)

Maven

Java 17 or later

Deployment Steps

Build the Docker image

mvn -DskipTests clean package
docker build -t task-api:latest .


Apply the Kubernetes manifests

kubectl apply -f mongo.yaml
kubectl apply -f mongo-pv.yaml
kubectl apply -f task-api.yaml


Verify deployment

kubectl get pods
kubectl get svc
kubectl get pvc,pv


Access the API from Postman or browser:

http://localhost:8080/api/tasks
