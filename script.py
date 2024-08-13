import time

# Set the number of log lines you want to generate
num_log_lines = 1000

for i in range(500000):
    # Log format with a timestamp and log message
    log_message = f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Log message {i}"
    
    # Print the log message to the console
    print(log_message)
    
    # You can add a delay if you want to simulate real-time logging
    # time.sleep(0.1)  # Uncomment this line for a delay between log entries
