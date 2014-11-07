FROM mhorbul/centos:base6

RUN yum groupinstall -y "Development tools"
RUN yum install -y tar

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv && \
    echo '# rbenv setup' > /etc/profile.d/rbenv.sh && \
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh && \
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && \
    chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins && \
    git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
