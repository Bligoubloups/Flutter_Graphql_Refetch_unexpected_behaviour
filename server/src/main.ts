import { ApolloServer, gql } from "apollo-server";

const typeDefs = gql`
  type Query {
    data: String
  }
`;

const resolvers = {
  Query: {
    data() {
      return "Hello " + new Date().toLocaleTimeString();
    },
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  playground: true,
  introspection: true,
  context: ({ req }) => req,
});

// The `listen` method launches a web server.
server.listen({ port: 6001 }).then(({ url }) => {
  console.log(`Server ready at ${url}`);
});
