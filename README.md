# Cab Booking System Project

## Overview

This project implements a cab booking system similar to Uber, featuring a backend system using Django, a MySQL database, and a React.js frontend. The system allows users to book cabs, complete trips, and manage various aspects of the cab booking process.

## Key Features

1. User authentication (sign up and login)
2. Cab booking functionality
3. Trip completion and payment handling
4. Real-time tracking and estimated time of arrival
5. Driver and cab management

## Database Structure

The system uses a relational database with the following main tables:

- Users
- Drivers
- Cabs
- Bookings
- Receipts

## Functionality

### User Interface

The system provides a console-based interface for users to:

- Sign up or log in
- Book a new cab
- Complete a trip

### Backend Operations

- User authentication and management
- Cab allocation based on availability and capacity
- Trip fare calculation
- Receipt generation

## Code Snippets

### Booking a Cab

```python
def bookCab(usr):
    pickup = input("Enter Pickup Location: ")
    drop = input("Enter Drop Location: ")
    capacity = int(input("Enter Number of Passengers: "))
    
    # Database operations to book a cab
    # ...

    return "Booking Successful with Cab Number: '{cabNum}'"
```
Completing a Trip
```python
def completeTrip(usr):
    # Database operations to complete a trip
    # ...

    return "Trip completed successfully"
```

## Database Queries
- The system uses various SQL queries for operations such as:
- Updating user information
- Checking available cabs
- Retrieving booking history
- Generating reports on popular routes

## Future Enhancements
- Implement a rating system for drivers and users
- Add a rewards program for frequent users
- Integrate real-time map services for accurate location tracking

## Conclusion
This cab booking system provides a solid foundation for managing cab bookings, user accounts, and trip completions. With its modular design and use of popular technologies, it can be easily extended and scaled for future improvements.
