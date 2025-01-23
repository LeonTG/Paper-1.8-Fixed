#!/bin/bash

checkIfJava8 () {
    # get just the version text
    _java_version=$("$1" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "Java Version ""${_java_version}"" detected!"

    # check if the java version text starts with "1.8"
    if [[ "${_java_version}" =~ ^"1.8" ]]; then
        _java8Exe="$1"
        return 0
    else
        return 1
    fi
}

tryJava8EnvironmentVariable() {
    echo "Attempting to use ""JAVA8_HOME"" environment variable..."

    # check if the JAVA8_HOME variable has been set, and has a java executable
    if [[ -n "$JAVA8_HOME" ]] && [[ -x "$JAVA8_HOME/bin/java" ]]; then

        # check if the java env variable version is java 8
        if checkIfJava8 "$JAVA8_HOME/bin/java"; then
            echo "Java 8 environment variable found! Proceeding..."
        else
            echo "Your ""JAVA8_HOME"" environment variable is not set to Java 8!"
            exit 1
        fi
    else
        echo "Could not find a ""JAVA8_HOME"" environment variable!"
        exit 1
    fi
}

getJava8() {
    echo "Detecting Java version..."

    # check if java command exists and is runnable
    if type -p java >/dev/null 2>&1; then

        # check if the java version is java 8
        if checkIfJava8 java; then
            echo "You are running Java 8! Proceeding..."
        else
            echo "PaperSpigot requires Java version 8 in order to build..."

            # our java isn't java 8, check if we got an environment variable setup to a java 8 executable
            tryJava8EnvironmentVariable
        fi
    else
        echo "Could not find a java installation!"
        echo "PaperSpigot requires Java version 8 in order to build..."

        # we got no java, check if we got an environment variable setup to a java 8 executable
        tryJava8EnvironmentVariable
    fi
}