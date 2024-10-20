# Archi HTML Report Generator

This project automates the generation of HTML reports from `.archimate` files using a Docker-based CI/CD pipeline in GitLab. The generated reports are deployed on GitLab Pages, making them readily accessible for review and sharing.

## Project Repository

The project is hosted on GitLab and can be accessed at the following link: [Archi HTML Report Generator on GitLab](https://gitlab.com/o.zalesky/archimate2html).

- **CI/CD Pipeline**: You can view the details of our continuous integration and deployment pipeline.
- **GitLab Pages**: The deployed HTML reports are accessible via GitLab Pages.

## Features

- **Automated Docker Image Creation**: Builds Docker images that include the necessary toolset for generating HTML reports.
- **Continuous Integration**: Uses GitLab CI/CD to automate the build, push, and deployment process.
- **GitLab Pages Deployment**: Publishes HTML reports to GitLab Pages for easy access.
- **Index Generation**: Automatically creates an index of all generated reports.

## Prerequisites

- **GitLab Account**: Required for repository hosting and running CI/CD pipelines.
- **Docker**: Ensure Docker is installed and running on the systems that initiate builds.
- **Archi**: The project uses the Archi tool to generate reports, included in the Docker image.

## Pipeline Configuration

### Stages

1. **Build**: 
   - Builds and pushes the Docker image to the GitLab container registry.
   - Triggered on changes to the `Dockerfile` or `.gitlab-ci.yml`.

2. **Pages**: 
   - Generates HTML reports from `.archimate` files.
   - Publishes the reports to GitLab Pages.

### Files

- **.gitlab-ci.yml**: Defines the CI/CD pipeline stages, jobs, and triggers.
- **Dockerfile**: Specifies the Docker image construction with Debian and Archi.
- **gen_html.sh**: Bash script to find `.archimate` files and generate HTML reports using Archi.

## Usage

1. **Clone Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Running the Pipeline**:
   - Push changes to the `main` branch to trigger the pipeline.
   - Ensure `.archimate`, `Dockerfile`, or `.gitlab-ci.yml` files are included in the commit to trigger respective stages.

3. **Accessing Reports**:
   - Navigate to the GitLab Pages URL: `https://<your-username>.gitlab.io/<project-name>/`
   - View and explore the generated HTML reports from `.archimate` files.

## Contribution

1. **Fork the Repository**.
2. **Create a New Branch**:
   ```bash
   git checkout -b feature/<feature-name>
   ```
3. **Commit Changes**:
   ```bash
   git commit -m "Add new feature"
   ```
4. **Push Branch**:
   ```bash
   git push origin feature/<feature-name>
   ```
5. **Create Pull Request**.

## Troubleshooting

- **Pipeline Failures**: Check the CI/CD job logs for specific error messages and ensure all dependencies are up-to-date.
- **Docker Issues**: Verify the Docker service is running and accessible.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
