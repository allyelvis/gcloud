app.post('/upload', upload.single('file'), async (req, res) => {
    try {
        const { platform } = req.body; // Expecting a "platform" field to know where to upload
        const filePath = req.file.path;
        
        let uploadResult;
        if (platform === 'youtube') {
            uploadResult = await uploadToYouTube(filePath, req.user.youtubeToken);
        } else if (platform === 'soundcloud') {
            uploadResult = await uploadToSoundCloud(filePath, req.user.soundCloudToken);
        }
        
        res.status(200).json({ success: true, data: uploadResult });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

app.listen(3000, () => console.log('Server running on port 3000'));
-F "snippet.title=My Video Title" \
        -F "snippet.description=My Video Description" \
        -F "snippet.tags[]=tag1,tag2" \
        -F "status.privacyStatus=public" \
        -F "media=@${file_path}" \
        "https://www.googleapis.com/upload/youtube/v3/videos?part=snippet,status" \
        -o response.json

    if [ $? -eq 0 ]; then
        echo "Video uploaded successfully to YouTube. Response:"
        cat response.json
    else
        echo "Failed to upload video to YouTube."
    fi
}

# Function to upload audio to SoundCloud
upload_to_soundcloud() {
    local file_path=$1
    local access_token=$2

    curl -X POST \
        -H "Authorization: OAuth $access_token" \
        -F "track[title]=My Track Title" \
        -F "track[asset_data]=@${file_path}" \
        "https://api.soundcloud.com/tracks" \
        -o response.json

    if [ $? -eq 0 ]; then
        echo "Audio uploaded successfully to SoundCloud. Response:"
        cat response.json
    else
        echo "Failed to upload audio to SoundCloud."
    fi
}

# Main script execution
echo "Select the platform to upload to:"
echo "1. YouTube"
echo "2. SoundCloud"
read -p "Enter the option number: " platform_option

read -p "Enter the file path of the media file: " file_path

if [ ! -f "$file_path" ]; then
    echo "File does not exist: $file_path"
    exit 1
fi

if [ "$platform_option" -eq 1 ]; then
    read -p "Enter your YouTube Access Token: " youtube_token
    upload_to_youtube "$file_path" "$youtube_token"
elif [ "$platform_option" -eq 2 ]; then
    read -p "Enter your SoundCloud Access Token: " soundcloud_token
    upload_to_soundcloud "$file_path" "$soundcloud_token"
else
    echo "Invalid option selected."
    exit 1
fi