import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

System.setProperty("hudson.model.DirectoryBrowserSupport.CSP", "sandbox; default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';")
System.setProperty("jenkins.model.DirectoryBrowserSupport.CSP", "sandbox; default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';")