# Git Mirror Script

This script allows you to perform a **bare mirror** operation using source and destination repositories defined in a JSON file. The script clones the source repositories locally and pushes them to the defined destination repositories, automating the mirroring process for multiple repositories. Thanks to [metinkilicaslan](https://github.com/metinkilicaslan) for contribution.

## Features
- Reads source and destination repositories from a JSON file.
- Uses **bare mirror** cloning for efficient repository mirroring.
- Pushes the cloned repositories to the specified destination repositories.

---

## Requirements
- **Bash 4.0 or newer**
- **jq** (for parsing JSON files)
- **Git**

To install `jq` and ensure your environment is ready, run the following command:

```
sudo apt update && sudo apt install jq -y
```

For other distributions:
- **CentOS/Fedora**:
  ```
  sudo yum install jq -y
  ```
- **macOS (Homebrew)**:
  ```
  brew install jq
  ```

---

## JSON Format

The script requires a properly formatted JSON file. Below is an example structure:

```
{
  "repos": {
    "https://github.com/user/abc.git": "/path/to/destination/abc.git",
    "https://github.com/user/xyz.git": "/path/to/destination/xyz.git"
  }
}
```

- **Key**: Source repository URL.
- **Value**: Destination path where the bare clone will be stored.

---

## Usage

### Running the Script

1. **Make the Script Executable**
   ```
   chmod +x mirror_repos.sh
   ```

2. **Run the Script**
   ```
   ./mirror_repos.sh /path/to/repos.json
   ```

   - `/path/to/repos.json`: Path to the JSON file.
   - If no JSON file is specified, the default path `$(pwd)/helper-scripts/repos.json` will be used.

## License

This script is open-source and can be used freely in any project.
