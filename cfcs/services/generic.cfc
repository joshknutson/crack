<cfcomponent displayname="generic" hint="contains generic operations" output="false">
<cffunction name="getCFDataType" returntype="string" hint="I return the cfsqltype for the cfqueryparam function">
  <cfargument name="type" required="yes" type="string" />

  <cfset var private = StructNew() />
  <cfswitch expression="#ListFirst(LCase(Trim(Arguments.Type)), ' ')#">
    <cfcase value="bigint">
      <cfset private.CFDataType = "CF_SQL_BIGINT" />
    </cfcase>
    <cfcase value="binary,image,sql_variant,sysname,varbinary" />
      <cfset private.CFDataType = "">
    </cfcase>
    <cfcase value="bit">
      <cfset private.CFDataType = "CF_SQL_BIT" />
    </cfcase>
    <cfcase value="char,nchar">
      <cfset private.CFDataType = "CF_SQL_CHAR" />
    </cfcase>
    <cfcase value="datetime,smalldatetime">
      <cfset private.CFDataType = "CF_SQL_DATE" />
    </cfcase>
    <cfcase value="decimal">
      <cfset private.CFDataType = "CF_SQL_DECIMAL" />
    </cfcase>
    <cfcase value="float">
      <cfset private.CFDataType = "CF_SQL_FLOAT" />
    </cfcase>
    <cfcase value="int">
      <cfset private.CFDataType = "CF_SQL_INTEGER" />
    </cfcase>
    <cfcase value="money">
      <cfset private.CFDataType = "CF_SQL_MONEY" />
    </cfcase>
    <cfcase value="ntext,text">
      <cfset private.CFDataType = "CF_SQL_LONGVARCHAR" />
    </cfcase>
    <cfcase value="numeric">
      <cfset private.CFDataType = "CF_SQL_NUMERIC" />
    </cfcase>
    <cfcase value="nvarchar,varchar">
      <cfset private.CFDataType = "CF_SQL_VARCHAR" />
    </cfcase>
    <cfcase value="real">
      <cfset private.CFDataType = "CF_SQL_REAL" />
    </cfcase>
    <cfcase value="smallint">
      <cfset private.CFDataType = "CF_SQL_SMALLINT" />
    </cfcase>
    <cfcase value="smallmoney">
      <cfset private.CFDataType = "CF_SQL_MONEY4" />
    </cfcase>
    <cfcase value="timestamp">
      <cfset private.CFDataType = "CF_SQL_TIMESTAMP" />
    </cfcase>
    <cfcase value="tinyint">
      <cfset private.CFDataType = "CF_SQL_TINYINT" />
    </cfcase>
    <cfcase value="uniqueidentifier">
      <cfset private.CFDataType = "CF_SQL_IDSTAMP" />
    </cfcase>
    <cfdefaultcase>
      <cfthrow message="unknown datatype" />
    </cfdefaultcase>
  </cfswitch>

  <cfreturn Trim(private.CFDataType) />
</cffunction>
<cffunction name="getTablePrimaryKey"
  returntype="query"
  hint="I return the fields that make up the primary key for a given table">
  <cfargument name="tablename" required="yes" type="string" />
  <cfargument name="datasource" required="yes" type="string" />

  <cfset var qryPrimaryKey = "" />

  <cfquery name="qryPrimaryKey" datasource="#Arguments.Datasource#">
    SELECT Column_Name
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
      INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
        ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
    WHERE tc.Table_Name = <cfqueryparam value="#Arguments.tablename#" cfsqltype="cf_sql_varchar" />
      AND CONSTRAINT_TYPE = 'PRIMARY KEY'
  </cfquery>

  <cfreturn qryPrimaryKey />
</cffunction>
<cffunction name="getTableFields"
  returntype="query"
  hint="I return all the fields and schema information for a given table">
  <cfargument name="tablename" required="yes" type="string" />
  <cfargument name="datasource" required="yes" type="string" />

  <cfset var qryTableFields = "" />

  <cfdbinfo datasource="#Arguments.Datasource#"
    table="#Arguments.tablename#"
    name="qryTableFields"
    type="columns" />

  <cfreturn qryTableFields />
</cffunction>
<cffunction name="getUserTables"
  returntype="query"
  hint="I return all the user tables for a datasource">
  <cfargument name="datasource" required="yes" type="string" />

  <cfset var qryTables = "" />

  <cfquery name="qryTables" datasource="#Arguments.Datasource#">
    SELECT Table_Name
    FROM INFORMATION_SCHEMA.TABLES
    WHERE Table_Type = 'BASE TABLE'
      AND Table_Name <> 'dtproperties'
    ORDER BY Table_Name
  </cfquery>

  <cfreturn qryTables />
</cffunction>
</cfcomponent>