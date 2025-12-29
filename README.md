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

## Architecture Overview

The application follows a service-oriented architecture. Controllers are intentionally thin and delegate business logic to service objects.

Core structure:

app/
├─ controllers/
│ ├─ dashboard_controller.rb
│ └─ messages_controller.rb
│
├─ services/
│ ├─ messages/
│ │ └─ create_and_dispatch.rb
│ │
│ └─ notifications/
│ ├─ dispatcher.rb
│ ├─ recipients_resolver.rb
│ ├─ sender_factory.rb
│ └─ senders/
│ ├─ base_sender.rb
│ ├─ sms_sender.rb
│ ├─ email_sender.rb
│ └─ push_sender.rb
│
├─ models/
│ ├─ user.rb
│ ├─ message.rb
│ ├─ notification_log.rb
│ ├─ user_category_subscription.rb
│ └─ user_channel_preference.rb


Design patterns applied:

- Strategy Pattern  
  Each notification channel implements its own sender class with independent delivery logic.

- Factory Pattern  
  A sender factory selects the appropriate sender based on the notification channel.

- Service Objects  
  Core business logic (message creation, recipient resolution, dispatching) lives outside controllers.

---

## User Interface

The application exposes two main UI components:

1. Message Submission Form  
   - Category selection
   - Message body input
   - Inline validation errors
   - Submission triggers message creation and notification dispatch

2. Notification Log History  
   - Sorted from newest to oldest
   - Server-side filters:
     - Category
     - Channel
     - Status
     - User search (name, email, or ID)
   - Pagination using Kaminari
   - Visual status indicators using Bootstrap badges

---

## Running the Application Locally

### Requirements

- Ruby 3.2.2
- Rails 7.2.1
- PostgreSQL

### Step 1: Clone the repository

```bash
git clone <repository-url>
cd NTG_Challenge

### Step 1: Install dependencies

bundle install
rails db:create
rails db:migrate
rails db:seed
rails s
http://localhost:3000


Possible Improvements

Background job processing for async delivery (e.g., Sidekiq)

Integration with real SMS, Email, and Push providers

User management interface

Delivery analytics and performance metrics