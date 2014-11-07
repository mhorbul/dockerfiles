FROM mhorbul/ruby:2.1.4

RUN useradd -r -u 1000 -m -d /home/rails -c "Rails application user" rails

VOLUME ["/data"]

ADD . /home/rails/app

RUN yum install -y sqlite3-devel

WORKDIR /home/rails/app
RUN chown -R rails:rails /home/rails/app
RUN su -c 'cd /home/rails/app && bundle install --deployment' - rails
