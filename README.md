# NTG Challenge – Notification Hub

NTG Challenge is a simple and extensible notification system built with Ruby on Rails.  
The application receives categorized messages and dispatches notifications to preconfigured users through their preferred channels.

This project was developed as part of a technical challenge, with strong emphasis on clean architecture, separation of concerns, fault tolerance, and scalability.

---

## Features

- Message submission with predefined categories:
  - Sports
  - Finance
  - Movies
- Notification dispatch rules:
  - Users receive messages only from categories they are subscribed to
  - Notifications are sent only through the channels selected by each user
- Supported notification channels:
  - SMS
  - Email
  - Push
- Independent sender class per channel (Strategy Pattern)
- Fault-tolerant delivery:
  - A failure in one channel does not stop other deliveries
- Complete notification audit log:
  - Message category
  - User
  - Channel
  - Status (pending, sent, failed, skipped)
  - Creation and delivery timestamps
  - Error details (when applicable)
- Modern UI built with Bootstrap:
  - Message submission form
  - Log history with server-side filters and pagination

---

## Running the Application Locally

### Requirements

- Ruby 3.2.2
- Rails 7.2.1
- PostgreSQL

### Step 1: Clone the repository

git clone https://github.com/LucasDCunha/NTD_Challenge
cd NTG_Challenge

### Step 2: Install dependencies

bundle install

### Step 3: Configure the database

rails db:create

rails db:migrate

rails db:seed

### Step 4: Start the server

rails s

### Step 5: Open localhost

http://localhost:3000

---

## Possible Improvements

Background job processing for async delivery (e.g., Sidekiq)

Integration with real SMS, Email, and Push providers

User management interface

Delivery analytics and performance metrics