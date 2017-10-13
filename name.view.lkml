view: name {
  derived_table: {
    persist_for: "500 hours"
    indexes: ["id"]
    sql:
      SELECT
        *
        {% if _dialect._name contains 'bigquery' %}
        , CONCAT(first_name, ' ', last_name) as person_name
        {% else %}
        , {% concat %} first_name || ' ' || last_name {% endconcat %} as person_name
        {% endif %}
        FROM (
          SELECT
            *

           {% if _dialect._name contains 'bigquery' %}
              , FIRST(SPLIT(name.name,', ')) AS last_name
              , NTH(2,SPLIT(name.name,', ')) as first_name
           {% elsif _dialect._name contains 'spark' %}
              , SPLIT(name.name, ', ')[1] as last_name
              , SPLIT(name.name, ', ')[0]) as first_name
          {% else %}
              , SPLIT_PART(name.name, ', ', 1) as last_name
              , SPLIT_PART(name.name, ', ', 2) as first_name
          {% endif %}
          FROM name
        ) as n
       ;;
  }

  dimension: id {
    label: "Person ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: gender {
    sql: ${TABLE}.gender ;;
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

  dimension: md5sum {
    sql: ${TABLE}.md5sum ;;
    hidden: yes
  }

  dimension: person_name {
    sql: ${TABLE}.person_name ;;
  }

  dimension: last_name {}
  dimension: first_name {}

  dimension: name_pcode_cf {
    sql: ${TABLE}.name_pcode_cf ;;
    hidden: yes
  }

  dimension: name_pcode_nf {
    sql: ${TABLE}.name_pcode_nf ;;
    hidden: yes
  }

  dimension: surname_pcode {
    sql: ${TABLE}.surname_pcode ;;
    hidden: yes
  }

  measure: person_count {
    type: count
    drill_fields: [id, person_name, gender, title.count]
  }

  measure: person_count_female {
    type: count
    drill_fields: [id, person_name, gender, title.count]
    filters: {
      field: gender
      value: "f"
    }
  }

  measure: person_percentage_female {
    type: number
    sql: ${person_count_female} / NULLIF(${person_count},0) ;;
    value_format_name: percent_2
  }
}
