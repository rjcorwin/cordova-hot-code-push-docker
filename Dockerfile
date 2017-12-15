FROM beevelop/android-nodejs:latest
ARG UPDATE_SERVER_URL

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN npm install -g cordova

WORKDIR /
RUN cordova create TangerineProject org.rti.tangerineproject TangerineProject

WORKDIR /TangerineProject
RUN cordova platform add android
RUN cordova plugin add cordova-hot-code-push-plugin

# RUN npm install -g cordova-hot-code-push-cli

# Add custom code in and update server url for cordova hot code push.
# ADD ./build /TangerineProject/www
# ADD ./content /TangerineProject/www/content
# @TODO replace update server url with value from build arg
# RUN sed -i "s#</description>#</description>\n    <chcp><config-file url=\"$UPDATE_SERVER_URL\" /></chcp>#' config.xml

RUN cordova build android

VOLUME /build
ENTRYPOINT cp -r /TangerineProject/platforms/android/build/outputs/apk/android-debug.apk /apks/
