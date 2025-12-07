# plutus

This project uses Quarkus, the Supersonic Subatomic Java Framework.

If you want to learn more about Quarkus, please visit its website: <https://quarkus.io/>.

## Database Configuration

This application uses **AWS Secrets Manager** for database credentials.

### Prerequisites

1. **PostgreSQL Database Running**:
```bash
docker run --name plutus_db \
  -e POSTGRES_PASSWORD=plutus_pass \
  -e POSTGRES_USER=plutus \
  -e POSTGRES_DB=plutus_db \
  -p 5432:5432 -d postgres:16-alpine
```

2. **AWS Credentials**: Configure in `~/.aws/credentials`:
```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

3. **AWS Region**: Set in `~/.aws/config`:
```ini
[default]
region = us-east-2
```

4. **AWS Secret**: Create a secret named "plutus" in AWS Secrets Manager:
```json
{
  "DB_USER": "plutus",
  "DB_PASSWORD": "plutus_pass"
}
```

### Testing AWS Connection

Run the test script to verify AWS is configured correctly:
```bash
./test-aws-connection.sh
```

## Running the application in dev mode

You can run your application in dev mode that enables live coding using:

```shell script
./gradlew quarkusDev
```

> **_NOTE:_**  Quarkus now ships with a Dev UI, which is available in dev mode only at <http://localhost:8080/q/dev/>.

## Packaging and running the application

The application can be packaged using:

```shell script
./gradlew build
```

It produces the `quarkus-run.jar` file in the `build/quarkus-app/` directory.
Be aware that it’s not an _über-jar_ as the dependencies are copied into the `build/quarkus-app/lib/` directory.

The application is now runnable using `java -jar build/quarkus-app/quarkus-run.jar`.

If you want to build an _über-jar_, execute the following command:

```shell script
./gradlew build -Dquarkus.package.jar.type=uber-jar
```

The application, packaged as an _über-jar_, is now runnable using `java -jar build/*-runner.jar`.

## Creating a native executable

You can create a native executable using:

```shell script
./gradlew build -Dquarkus.native.enabled=true
```

Or, if you don't have GraalVM installed, you can run the native executable build in a container using:

```shell script
./gradlew build -Dquarkus.native.enabled=true -Dquarkus.native.container-build=true
```

You can then execute your native executable with: `./build/plutus-1.0-SNAPSHOT-runner`

If you want to learn more about building native executables, please consult <https://quarkus.io/guides/gradle-tooling>.

## Related Guides

- Kotlin ([guide](https://quarkus.io/guides/kotlin)): Write your services in Kotlin

## Provided Code

### REST

Easily start your REST Web Services

[Related guide section...](https://quarkus.io/guides/getting-started-reactive#reactive-jax-rs-resources)
