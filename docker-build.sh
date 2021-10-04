git_hash=$(git rev-parse --short "$GITHUB_SHA")
git_branch=${GITHUB_REF#refs/heads/}
docker_version=${git_branch}-${git_hash}
