*** Settings ***
Library    SSHLibrary

*** Variables ***
${SSH_PORT}    22

*** Keywords ***

Connect To Router
    Open Connection    ${RG_IP}
    Login    ${RG_USERNAME}    ${RG_PASSWORD}

USP Query
    [Arguments]    ${command}
    ${out}=    Execute Command    echo "${command}" | usp-cli -a
    Should Not Contain    ${out}    ERROR
    [Return]    ${out}
