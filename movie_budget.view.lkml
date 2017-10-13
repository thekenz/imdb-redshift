view: movie_budget {
  derived_table: {
    persist_for: "100 hours"
    indexes: ["movie_id"]
    sql: SELECT
        movie_id
        , info
        {% if _dialect._name contains 'spark' %}
        ,regexp_extract(info,'^[^\\d\\s]*',0)
           as budget_currency
        , CAST(REGEXP_REPLACE(info, '[^\\d]','') AS DECIMAL(38,10))/1000000.0 as budget
        {% else %}
        , REGEXP_SUBSTR(info,'^[^\\d\\s]*') as budget_currency
        , CAST(NULLIF(REGEXP_REPLACE(info, '[^\\d]'),'') AS NUMERIC)/1000000 as budget
        {% endif %}
        , ROW_NUMBER() OVER(ORDER BY movie_id) as id
      FROM movie_info
      WHERE movie_info.info_type_id = 105
       ;;
  }

  dimension: id {
    primary_key: yes
    hidden: yes
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: info {}
  dimension: budget_currency {}

  dimension: budget {
    type: number
    value_format: "#,##0.00 \M"
  }

  measure: total_budget {
    type: sum
    sql: ${budget} ;;
    value_format: "#,##0.00 \M"
    #filters:
    #  budget_currency: '$'
    html: {{ budget_currency }} {{rendered_value}}
      ;;
  }

  measure: average_budget {
    type: average
    sql: ${budget} ;;
    value_format: "#,##0.00 \M"
    drill_fields: [movie_id, budget, budget_currency, info]
  }
}
