import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/app_states.dart';
import 'package:flutter_bloc_project/app_events.dart';
import 'package:flutter_bloc_project/app_blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBlocs(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterBlocs, CounterStates>(builder: (context, state) {
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.counter.toString(),
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<CounterBlocs>(context).add(Increment()),
                    child: const Icon(Icons.add)),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<CounterBlocs>(context).add(Decrement()),
                    child: const Icon(Icons.remove))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondPage()));
              },
              child: Container(
                width: 138,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 224, 16, 96),
                ),
                child: const Center(
                    child: Text(
                  "click",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        );
      }),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBlocs counterBloc = BlocProvider.of<CounterBlocs>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blocs"),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder(
            bloc: counterBloc,
            builder: (context, state) {
              return Center(
                child: Text(
                  counterBloc.state.counter.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
              );
            }));
  }
}
