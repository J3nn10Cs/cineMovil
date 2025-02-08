import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/searchs/search_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomsAppbar extends ConsumerWidget {
  const CustomsAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final colors = Theme.of(context).colorScheme;
    final tittleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: SizedBox(
          //darle todo el ancho que se pueda
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color:colors.primary ,),
              SizedBox(width: 5,),
              Text('Cinemapedia', style: tittleStyle,),
              //igual al flex que tome todo el espacio disponible
              Spacer(),
              IconButton(
                onPressed: (){

                  final searchRepository = ref.read(searchRepositoryProvider);
                  
                  showSearch(
                    context: context, 
                    delegate: SearchMovieDelegate(
                      searchMovies: searchRepository.getSearchMovie
                    )
                  );
                },
                icon: Icon(Icons.search)
              )
            ],
          ),
        ),
        
      ),
    );
  }
} 