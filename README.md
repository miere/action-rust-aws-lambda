# Generate AWS Lambda package for Rust
This is a (WIP) GitHub Action that generates AWS Lambda compatible packages
for your Rust project.

## Acknowledgements
This project wouldn't be possible without the [softprops/lambda-rust](https://github.com/softprops/lambda-rust)
Docker Image and all the effort its [contributors](https://github.com/softprops/lambda-rust/graphs/contributors)
have put to generate a convenient foundation for building Rust packages using Docker.

## How it works?
This action will use a customized Docker image that will generate a zip file for all Rust binaries created
by your project. Each tagged version of this action is compatible with a Rust version of the same name.

## Usage
```yml
name: Deployment

on:
  workflow_dispatch:

jobs:
  package:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
        name: Checkout Source Code

      - name: Building and packaging AWS Lambda functions
        uses: miere/rust-aws-lambda@1.51.0
        id: rust-aws-lambda
        # Only required if your source is not in the root folder
        # By default, source-dir points to '.'
        with:
          source-dir: "source"

      # Do something with the generated zip files
      # They will be generated at the target folder of your project.
      - name: Archive artifacts
        uses: actions/upload-artifact@v2
        with:
          name: "{{process.env.GITHUB_RUN_ID}}"
          path: "source/target/lambda/*.zip"

```
