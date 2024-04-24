#!/bin/bash

# Function to check if Gitleaks is installed and install if it's not
function check_gitleaks_installed {
  if ! command -v gitleaks &>/dev/null; then
    echo "Gitleaks is not installed. Attempting to install..."
    # Adjust the installation command according to your environment
    # For example, using Homebrew on macOS:
    brew install gitleaks || {
      echo "Failed to install Gitleaks. Exiting."
      exit 1
    }
  fi
}

# Function to check if pre-commit is installed and install if it's not
function check_pre_commit_installed {
  if ! command -v pre-commit &>/dev/null; then
    echo "pre-commit is not installed. Attempting to install..."
    pip install pre-commit || {
      echo "Failed to install pre-commit. Exiting."
      exit 1
    }
  fi
}

# Function to install pre-commit hooks
function install_pre_commit_hooks {
  echo "Installing pre-commit hooks..."
  pre-commit install || {
    echo "Failed to install pre-commit hooks. Exiting."
    exit 1
  }
}

# Function to run Gitleaks scan
function run_gitleaks_scan {
  echo "Running Gitleaks scan..."
  # Adjust the command as necessary. Here it scans the current repository.
  gitleaks protect --verbose --redact --staged || {
    echo "Gitleaks detected secrets. Exiting."
    exit 1
  }
}

# Main script execution
check_pre_commit_installed
check_gitleaks_installed
install_pre_commit_hooks
run_gitleaks_scan

echo "Pre-commit hooks and Gitleaks scan completed successfully."
