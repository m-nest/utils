*** Settings ***
Library    SSHLibrary

Suite Setup       Connect To Router
Suite Teardown    Close All Connections

*** Variables ***
${SSH_PORT}    22

*** Keywords ***

Connect To Router
    Open Connection    ${RG_IP}
    Login    ${RG_USERNAME}    ${RG_PASSWORD}

USP Query
    [Arguments]    ${cmd}
    ${out}=    Execute Command    echo "${cmd}" | usp-cli -a
    [Return]    ${out}

*** Test Cases ***

T001 SSH Login
    ${out}=    Execute Command    echo alive
    Should Be Equal    ${out}    alive

T002 USP CLI Installed
    ${out}=    Execute Command    which usp-cli
    Should Contain    ${out}    usp-cli

T003 Broker Socket Exists
    ${out}=    Execute Command    ls /var/run/usp/
    Should Contain    ${out}    broker_agent_path

T004 USP CLI Responds
    ${out}=    USP Query    help
    Should Contain    ${out}    help

T005 List Requests
    ${out}=    USP Query    requests
    Should Not Contain    ${out}    ERROR

T006 List Subscriptions
    ${out}=    USP Query    subscriptions
    Should Not Contain    ${out}    ERROR
