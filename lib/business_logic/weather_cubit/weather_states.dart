
abstract class WeatherStates{

}

class InitialState extends WeatherStates{

}

class GetWeatherDataLoadingState extends WeatherStates{

}

class GetWeatherDataSuccessState extends WeatherStates{

}

class GetWeatherDataErrorState extends WeatherStates{

}

class SelectWeatherImageState extends WeatherStates{

}

class GetWeatherDataSearchLoadingState extends WeatherStates{

}

class GetWeatherSearchDataSuccessState extends WeatherStates{

}

class GetWeatherDataSearchErrorState extends WeatherStates{

}

class ChangeFavoriteIconColorState extends WeatherStates{

}


// Sql Database

class CreateTableState  extends WeatherStates{}

class CreateDatabaseSuccessState  extends WeatherStates{}

class CreateDatabaseErrorState  extends WeatherStates{}

class InsertDatabaseSuccessState  extends WeatherStates{}

class InsertDatabaseErrorState  extends WeatherStates{}

class GetDatabaseSuccessState  extends WeatherStates{}

class GetDatabaseErrorState  extends WeatherStates{}

class UpdateDatabaseSuccessState  extends WeatherStates{}

class UpdateFavoriteSuccessState  extends WeatherStates{}

class GetScheduleDatabaseSuccessState  extends WeatherStates{}

class DeleteDatabaseSuccessState  extends WeatherStates{}


