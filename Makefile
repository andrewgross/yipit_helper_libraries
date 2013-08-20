all: clean install

install:
	bundle install
	bundle exec berks install

test:
	@bundle exec bash ${CHEF_PATH}/scripts/rspec_test.sh
	@bundle exec bash ${CHEF_PATH}/scripts/code_coverage_test.sh

vagrant:
	@if [ -a .vagrant ];\
		then vagrant provision;\
	else\
		vagrant up;\
	fi

ssh:
	@vagrant ssh $(filter-out $@,$(MAKECMDGOALS))

status:
	@vagrant status

clean:
	@rm -f Berksfile.lock
	@rm -f Gemfile.lock
	@if [ -a .vagrant ];\
		then vagrant destroy -f;\
		rm -rf .vagrant;\
	fi
