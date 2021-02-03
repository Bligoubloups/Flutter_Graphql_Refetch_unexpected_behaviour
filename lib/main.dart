import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client;
void main() {
  final HttpLink httpLink = HttpLink(
    'http://192.168.1.19:6001/graphql',
  );

  Link link = httpLink;

  client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ),
  );
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Bug flutter graphql'),
          ),
          body: Column(
            children: [
              Center(
                child: SubscribeWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscribeWidget extends StatelessWidget {
  const SubscribeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Query(
        options: QueryOptions(
          document: gql(query),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.isLoading) {
            return Text('Loading');
          }

          return Column(
            children: [
              RaisedButton(
                onPressed: () {
                  try {
                    refetch();
                  } catch (err) {}
                },
                child: Text("Refresh"),
              ),
              result.hasException
                  ? Text(
                      "No Network",
                    )
                  : Text(
                      result.data["data"],
                    ),
            ],
          );
        },
      ),
    );
  }
}

String query = """
  query Query() {
    data
  }
""";
