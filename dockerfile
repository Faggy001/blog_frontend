FROM node:18.19 AS build

WORKDIR /app

COPY package.json ./

RUN npm install 

COPY . .

RUN npm run build


#Test stage
FROM build AS test

RUN npm run test 

#production stage

FROM node:18.19

WORKDIR /app

COPY --from=build /app/node_modules/. node_modules/

COPY --from=build /app . 

EXPOSE 3000

ENV NODE_ENV=production


CMD ["npm", "start"]