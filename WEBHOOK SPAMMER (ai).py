import requests
import time

# Replace with your webhook URL
WEBHOOK_URL = 'YOUR_WEBHOOK_HERE'

# Function to send data to the webhook
def send_webhook(data):
    try:
        # Sending POST request with the message payload
        response = requests.post(WEBHOOK_URL, json=data)  
        
        # Log the request and the response
        print(f"Log: Sending data: {data}")  # Added log for the data sent
        
        if response.status_code == 200:
            print("Log: Message sent!")  # Log for a successful send
        else:
            print(f"Log: Failed to send message. Status Code: {response.status_code} | Response: {response.text}")
    except Exception as e:
        print(f"Log: Error sending webhook: {e}")

def main():
    while True:
        try:
            num_messages = int(input("Enter the number of messages to send: "))
            if num_messages > 0:
                break
            else:
                print("Please enter a positive integer.")
        except ValueError:
            print("Invalid input! Please enter a valid number.")
    
    message = input("Enter the message you want to send: ").strip()

    if not message:
        print("Error: The message cannot be empty. Please provide a valid message.")
        return  

    data_to_send = {
        "content": message  # Adjust key name based on what your webhook expects
    }

    for i in range(num_messages):
        print(f"Log: Sending message {i + 1} of {num_messages}...")
        send_webhook(data_to_send)
        time.sleep(1)  # Pause between requests
    
    print("Log: Finished sending messages.")

if __name__ == "__main__":
    main()