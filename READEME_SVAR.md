# Besvarelse PGR301 Eksamen 2026

## 1A

Dockerfilen er multi-stage build:
- **Build-Stage** (`maven:3.9-eclipse-temurin-21`) bygger JAR-filen med Maven. `pom.xml` kopieres før kildekoden slik at avhengighetene caches i et eget lag og ikke lastes ned på nytt ved hver kodeendring.
- **Runtime-stage** (`eclipse-temurin:21-jre`) inneholder kun Java-runtime og den ferdige JAR-filen. Maven, JDK og kildekode blir igjen i build-stagen, noe som gir et mindre image med færre avhengigheter.

AWS-nøkler bygges ikke inn i imaget, men sendes inn som miljøvariabler ved oppstart.

### Bygg og kjør (fra repo-root)
docker biuld -t wishifai

docker run --rm -p 9999:8080 \
  -e AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) \
  -e AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) \
  -e AWS_REGION=eu-west-1 \
  -e S3_BUCKET=fb-eksamen2026-25 \
  wishifai

### Test
```bash
curl -F "image=@samples/sample_image.png" http://localhost:9999/api/analyze
```

## 1B

### Lenke til grønn kjøring
https://github.com/FredrickBWolff/Eksamen-DevOps-kn-25/actions/runs/42255182164

### Begrunnelse tagging-strategi
Byttet fra full-sha til short-sha fordi sannsynligheten for at to blir like i et lite prosjekt som det her er veldig liten. Latest gjør det også enklere å hente det siste imaget fra docker hub.
