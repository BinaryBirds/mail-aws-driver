test: env
	swift test --enable-test-discovery --parallel

env:
	echo 'REGION="eu-central-1"' > .env.testing
