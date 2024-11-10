setup:	
		if command -v pip &> /dev/null; then \
			pip install -r requirements-dev.txt -r requirements.txt \
 \
; \
		elif command -v pip3 &> /dev/null; then \
			pip3 install -r requirements-dev.txt -r requirements.txt \
 \
; \
		else \
			echo "Error: pip and pip3 are not installed"; \
		fi

test-with-runnerv2:
	sudo docker compose -f docker-compose.yml rm -fsv
	sudo docker compose -f docker-compose.yml up -d --build minio
	sudo docker-compose -f docker-compose.yml build --build-arg EXECUTOR='argo' model
	sudo docker-compose run -e EXECUTOR='argo' model
test-with-runner:
	sudo docker compose -f docker-compose.yml rm -fsv
	sudo docker compose -f docker-compose.yml up -d --build minio createbucket
	sudo docker-compose -f docker-compose.yml build --build-arg EXECUTOR='kube' model
	sudo docker-compose run -e EXECUTOR='kube' model "$$(cat demo-test/sample_model_inputs.json)"

tear-down:
	sudo docker-compose down --volumes --remove-orphans