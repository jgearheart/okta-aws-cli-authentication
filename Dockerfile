FROM ubuntu

# author
MAINTAINER Jeremiah Gearheart

# extra metadata
LABEL version="1.0"
LABEL description="Ubuntu Container running okta-aws assume role tool"

# update sources list
RUN apt-get clean
RUN apt-get update
RUN echo Y | apt-get upgrade

# install basic apps, one per line for better caching
RUN apt-get install -qy git
RUN apt-get install -qy locales
RUN apt-get install -qy nano
RUN apt-get install -qy tmux
RUN apt-get install -qy wget
RUN apt-get install -qy curl

# install app runtimes and modules
RUN apt-get update && \
    apt-get install -y \
        python \
        python-pip \
        python-setuptools \
        groff \
        less \
    && pip --no-cache-dir install --upgrade awscli \
    && apt-get clean
RUN export PATH=~/.local/bin:$PATH
RUN echo Y | apt install default-jdk
RUN echo Y | apt install maven
RUN PREFIX=~/.okta 
RUN cd $HOME && wget https://raw.githubusercontent.com/oktadeveloper/okta-aws-cli-assume-role/master/bin/install.sh
RUN pwd
RUN ls
RUN cd $HOME && chmod +x install.sh
RUN cd $HOME && bash install.sh -i
#check installs
RUN java -version
RUN mvn -version



# cleanup
RUN apt-get -qy autoremove

RUN printf '%s\n' '#OktaAWSCLI' >> ~/.bash_profile  
RUN printf '%s\n' 'if [[ -f "$HOME/.okta/bash_functions" ]]; then' >> ~/.bash_profile
RUN printf '%s\n' '. "$HOME/.okta/bash_functions"' >> ~/.bash_profile
RUN printf '%s\n' 'fi' >> ~/.bash_profile
RUN printf '%s\n' 'if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then' >> ~/.bash_profile
RUN printf '%s\n' 'PATH="$HOME/.okta/bin:$PATH"' >> ~/.bash_profile
RUN printf '%s\n' 'fi' >> ~/.bash_profile
RUN printf '%s\n' '#OktaAWSCLI' >> ~/.bashrc 
RUN printf '%s\n' 'if [[ -f "$HOME/.okta/bash_functions" ]]; then' >> ~/.bashrc 
RUN printf '%s\n' '. "$HOME/.okta/bash_functions"' >> ~/.bashrc 
RUN printf '%s\n' 'fi' >> ~/.bashrc 
RUN printf '%s\n' 'if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then' >> ~/.bashrc 
RUN printf '%s\n' 'PATH="$HOME/.okta/bin:$PATH"' >> ~/.bashrc 
RUN printf '%s\n' 'fi' >> ~/.bashrc 


