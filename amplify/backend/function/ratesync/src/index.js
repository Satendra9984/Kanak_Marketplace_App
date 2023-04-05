import crypto from '@aws-crypto/sha256-js';
import { defaultProvider } from '@aws-sdk/credential-provider-node';
import { SignatureV4 } from '@aws-sdk/signature-v4';
import { HttpRequest } from '@aws-sdk/protocol-http';
import { default as fetch, Request } from 'node-fetch';
import FormData from 'form-data';

const GRAPHQL_ENDPOINT = process.env.API_TASVAT_GRAPHQLAPIENDPOINTOUTPUT;
const AWS_REGION = process.env.AWS_REGION || 'us-east-1';
const EMAIL = process.env.email;
const PASSWORD = process.env.password;

const { Sha256 } = crypto;

const getTokenQuery = `
  query ListToken {
    listTokens {
      items {
        id
        token
        expiry
        _version
      }
    }
  }
`;

const updateTokenQuery = `
  mutation UpdateToken($id: ID!, $token: String!, $expiry: AWSDateTime!, $version: Int! ) {
    updateToken(input: {id: $id, expiry: $expiry, token: $token, _version: $version}) {
      token
      _version
      expiry
    }
  }
`;

const addRateRecordQuery = `
  mutation CreateMarketRate($buy: Float!, $sell: Float!, $blockId: String!) {
    createMarketRate(input: {buy: $buy, sell: $sell, blockId: $blockId}) {
      id
      buy
      sell
      blockId
    }
  }
`;

const queryGraphQl = async (query) => {
  const endpoint = new URL(GRAPHQL_ENDPOINT);

  const signer = new SignatureV4({
    credentials: defaultProvider(),
    region: AWS_REGION,
    service: 'appsync',
    sha256: Sha256
  });

  const requestToBeSigned = new HttpRequest({
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      host: endpoint.host
    },
    hostname: endpoint.host,
    body: JSON.stringify({ query }),
    path: endpoint.pathname
  });

  const signed = await signer.sign(requestToBeSigned);
  return new Request(endpoint, signed);
}

const queryGraphQlWithVariable = async (query, variables) => {
  const endpoint = new URL(GRAPHQL_ENDPOINT);

  const signer = new SignatureV4({
    credentials: defaultProvider(),
    region: AWS_REGION,
    service: 'appsync',
    sha256: Sha256
  });

  const requestToBeSigned = new HttpRequest({
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      host: endpoint.host
    },
    hostname: endpoint.host,
    body: JSON.stringify({ query, variables }),
    path: endpoint.pathname
  });

  const signed = await signer.sign(requestToBeSigned);
  return new Request(endpoint, signed);
}

export const handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  let getTokenReq = await queryGraphQl(getTokenQuery);
  let statusCode = 200;
  let body;

  
  try {
      await fetch(getTokenReq).then(async tokenRes => {
        let token = await tokenRes.json();
        let prevToken = token.data.listTokens.items[0];
        let now = new Date().getTime();
        if (Date.parse(prevToken.expiry) - now < 7200000) {
          const formData = new FormData();
          formData.append("email", EMAIL);
          formData.append("password", PASSWORD);
          await fetch('https://uat-api.augmontgold.com/api/merchant/v1/auth/login', {
            method: 'POST',
            body: formData
          }).then(async credRes => {
            let cred = await credRes.json();
            let expireDate = new Date(cred.result.data.expiresAt);
            let variables = {
              id: prevToken.id,
              version: prevToken._version,
              expiry: expireDate.toISOString(),
              token: cred.result.data.accessToken
            };
            let updateTokenReq = await queryGraphQlWithVariable( updateTokenQuery, variables);
            await fetch(updateTokenReq).then(async newTokenRes => {
              let newToken = await newTokenRes.json();
              body = newToken;
              prevToken = newToken.data.updateToken;
            });
          });
        }
        await fetch('https://uat-api.augmontgold.com/api/merchant/v1/rates', {
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${prevToken.token}`
          }
        }).then(async rateRes => {
          let rate = await rateRes.json();
          console.log(rate);
          let variables = {                  
            buy: parseFloat(rate.result.data.rates.gBuy),
            sell: parseFloat(rate.result.data.rates.gSell),
            blockId: rate.result.data.blockId
          };
          let addRateRecordReq = await queryGraphQlWithVariable( addRateRecordQuery, variables );
          await fetch(addRateRecordReq).then(async addedRateRes => {
            let addedRate = await addedRateRes.json();
            console.log(addedRate);
            body = {
              record: addedRate,
              result: "Updated Rate"
            };
          });
        });
          
        if (body.errors) statusCode = 400;
      });
    
  } catch (error) {
    statusCode = 500;
    body = {
      errors: [
        {
          message: error.message
        }
      ]
    };
  }
  return {
    statusCode,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*"
    }, 
    body: JSON.stringify(body)
  };
};