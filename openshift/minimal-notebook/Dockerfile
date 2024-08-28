FROM centos/python-38-centos7:latest
USER root
RUN adduser -ms /bin/bash notebook && chown -R notebook:notebook /tmp && chmod 755 /tmp && chmod -R g+w /tmp/src

USER notebook

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    rm -rf /tmp/scripts && \
    mv /tmp/src/.s2i/bin /tmp/scripts   
    
RUN chmod +x /tmp/scripts/assemble && \
    ls -l /tmp/scripts

LABEL io.k8s.description="S2I builder for custom Jupyter notebooks." \
      io.k8s.display-name="Jupyter Notebook" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,jupyter" \
      io.openshift.s2i.scripts-url="image:///opt/app-root/builder"

RUN /tmp/scripts/assemble

RUN ls -l /opt/app-root/bin/

CMD [ "/opt/app-root/builder/run" ]
