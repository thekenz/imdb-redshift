view: title_base {

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: imdb_id {
    type: number
    sql: ${TABLE}.imdb_id ;;
    hidden: yes
  }

  dimension: imdb_index {
    sql: ${TABLE}.imdb_index ;;
    hidden: yes
  }

  dimension: kind_id {
    type: number
    sql: ${TABLE}.kind_id ;;
    hidden: yes
  }

  dimension: title {
    sql: ${TABLE}.title ;;
  }

  dimension: production_year {
    type: number
    sql: ${TABLE}.production_year ;;
  }
}
