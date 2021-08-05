# action-bump_version

🕷 Bump version name and code when you push

## Usage

To use the action simply add the following lines to your `.github/workflows/android.yml` and provide the required Secrets and Environment variables.

#### YML
```
name: Bump application version

on:
  push:
    tags:
      - '*'

jobs:
  Gradle:
    runs-on: ubuntu-latest
    steps:
    - name: checkout code
      uses: actions/checkout@v2
    - name: setup jdk
      uses: actions/setup-java@v1
      with:
        java-version: 11
    - name: Make Gradle executable
      run: chmod +x ./gradlew
    - name: Build Release APK
      run: ./gradlew assembleRelease
    - name: Releasing using Hub
      uses: VladDaniliuk/action-release-releaseapk@master
      env:
       GITHUB_TOKEN: ${{ secrets.TOKEN }}
       VERSION_NAME: versionName
       VERSION_CODE: versionCode
       APP_FILE: buildSrc/Android.kt
       CHANGES_LEVEL: changesLevel
```

### Secrets

You'll need to provide this secret token to use the action (for publishing the APK). Enter these secrets in your Settings > Secrets

* **TOKEN**: Create a new [access token](https://github.com/settings/tokens) with `repo` access.

I am unsure as to why using the default `GITHUB_TOKEN` provided universally will fail to authorize the user. This is the only workaround that I'd found.

### Environment Variables

You'll need to provide these environment variables to specify exactly what information is needed to build the APK.

* **APP_FILE**: file to search for the versin. This action only used with kotlins `buildSrc`
* **VERSION_NAME**: variable in buildSrc with version name
* **VERSION_CODE**: variable in buildsrc with version code
* **CHANGES_LEVEL**: variable that say level of changes (`small`,`medium`,`big`)

## Credits

Based off [ShaunLWM/action-release-debugapk](https://github.com/ShaunLWM/action-release-debugapk) and [kyze8439690/action-release-releaseapk](https://github.com/kyze8439690/action-release-releaseapk)
