view: movie_country_rating {
  derived_table: {
    persist_for: "100 hours"
    indexes: ["movie_id"]
    sql: SELECT
        movie_id
        , SPLIT_PART(movie_info.info,':', 1) AS country
        , SPLIT_PART(movie_info.info,':', 2) AS rating
        , movie_info.info AS country_rating
      FROM movie_info
      WHERE movie_info.info_type_id = 5
       ;;
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: country {}
  dimension: movie_rating {
    description: "Motion Picture Association of America film rating system - Example: 'PG-13'"
    sql: ${TABLE}.rating ;;
  }
  dimension: country_rating {}
}
