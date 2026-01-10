#!/bin/bash

# Set the source and target directories
source_dir="/web/conf/config/nginxgee"
target_dir="/etc/nginx/sites-enabled"

# Remove the default Nginx configuration
sudo rm "$target_dir/default"

# Iterate through all the configuration files in the source directory
for conf_file in "$source_dir"/*.conf; do
    # Get the base file name
    file_name=$(basename "$conf_file")
    
    # Create a symbolic link in the target directory
    sudo ln -s "$conf_file" "$target_dir/$file_name"
done

# Test the Nginx configuration for any syntax errors
sudo nginx -t

# If the configuration is valid, reload Nginx to apply the changes
if [ $? -eq 0 ]; then
    sudo systemctl reload nginx
else
    echo "Error: Nginx configuration test failed."
fi
