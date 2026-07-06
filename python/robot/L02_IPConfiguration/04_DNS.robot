*** Settings ***
Resource    ../common.resource

*** Test Cases ***

L2-030 DNS Resolver Configured
    ${out}=    Execute Command    cat /tmp/resolv.conf*
    Should Match Regexp    ${out}    .*nameserver.*

L2-031 DNS Resolution
    ${out}=    Execute Command    nslookup openwrt.org
    Should Not Contain    ${out}    NXDOMAIN
    Should Not Contain    ${out}    SERVFAIL

L2-032 Gateway Resolves Hostname
    ${out}=    Execute Command    ping -c1 openwrt.org
    Should Contain    ${out}    bytes from
