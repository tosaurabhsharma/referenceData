DROP TYPE T_REFERENCEDATA FORCE
/
DROP TYPE O_REFERENCEDATA FORCE
/
CREATE OR REPLACE TYPE O_REFERENCEDATA UNDER O_BASEREFERENCEDATA 
(
	
	CONSTRUCTOR FUNCTION O_REFERENCEDATA
RETURN SELF AS RESULT
	,CONSTRUCTOR FUNCTION O_REFERENCEDATA
	(
		id VARCHAR2
	) RETURN SELF AS RESULT
	,CONSTRUCTOR FUNCTION O_REFERENCEDATA
	(
		id VARCHAR2
		,status VARCHAR2
	) RETURN SELF AS RESULT

	,CONSTRUCTOR FUNCTION O_REFERENCEDATA
	(
		id VARCHAR2
		,shortDescription VARCHAR2
		,longDescription VARCHAR2
		,referenceDatacode VARCHAR2
		,key01 VARCHAR2
		,key02 VARCHAR2
		,key03 VARCHAR2
		,key04 VARCHAR2
		,value01 VARCHAR2
		,value02 VARCHAR2
		,value03 VARCHAR2
		,value04 VARCHAR2
		,value05 VARCHAR2
		,value06 VARCHAR2
		,status VARCHAR2
		,startDate DATE
		,endDate DATE
		,environment VARCHAR2
		,category VARCHAR2
		,isDefault VARCHAR2
	) RETURN SELF AS RESULT

)
/
CREATE OR REPLACE TYPE BODY O_REFERENCEDATA AS 
    --{LOCALE}	
	CONSTRUCTOR FUNCTION O_REFERENCEDATA
    RETURN SELF AS RESULT
    AS
    BEGIN
        RETURN;
    END;	
	CONSTRUCTOR FUNCTION O_REFERENCEDATA
    (
        id VARCHAR2
    ) RETURN SELF AS RESULT
    AS
    BEGIN
        SELF.id   := id ;
        RETURN;
    END;
    CONSTRUCTOR FUNCTION O_REFERENCEDATA
    (
        id 	VARCHAR2
		,status		VARCHAR2	
    ) RETURN SELF AS RESULT
    AS
    BEGIN
        SELF.id   		:= id ;
		SELF.status   	:= status ;
        RETURN;
    END;
    CONSTRUCTOR FUNCTION O_REFERENCEDATA
    (
		id VARCHAR2
		,shortDescription VARCHAR2
		,longDescription VARCHAR2
		,referenceDatacode VARCHAR2
		,key01 VARCHAR2
		,key02 VARCHAR2
		,key03 VARCHAR2
		,key04 VARCHAR2
		,value01 VARCHAR2
		,value02 VARCHAR2
		,value03 VARCHAR2
		,value04 VARCHAR2
		,value05 VARCHAR2
		,value06 VARCHAR2
		,status VARCHAR2
		,startDate DATE
		,endDate DATE
		,environment VARCHAR2
		,category VARCHAR2
		,isDefault VARCHAR2
    ) RETURN SELF AS RESULT
    AS
    BEGIN
		SELF.id := id;
		SELF.shortDescription := shortDescription;
		SELF.longDescription := longDescription;
		SELF.referenceDatacode := referenceDatacode;
		SELF.key01 := key01;
		SELF.key02 := key02;
		SELF.key03 := key03;
		SELF.key04 := key04;
		SELF.value01 := value01;
		SELF.value02 := value02;
		SELF.value03 := value03;
		SELF.value04 := value04;
		SELF.value05 := value05;
		SELF.value06 := value06;
		SELF.status := status;
		SELF.startDate := startDate;
		SELF.endDate := endDate;
		SELF.environment := environment;
		SELF.category := category;
		SELF.isDefault := isDefault;
        RETURN;
    END;
	
/*
	 CONSTRUCTOR FUNCTION O_REFERENCEDATA
    (
		id VARCHAR2
		,shortDescription VARCHAR2
		,longDescription VARCHAR2
		,referenceDatacode VARCHAR2
		,key01 VARCHAR2
		,key02 VARCHAR2
		,key03 VARCHAR2
		,key04 VARCHAR2
		,value01 VARCHAR2
		,value02 VARCHAR2
		,value03 VARCHAR2
		,value04 VARCHAR2
		,value05 VARCHAR2
		,value06 VARCHAR2
		,status VARCHAR2
		,startDate DATE
		,endDate DATE
		,environment VARCHAR2
		,category VARCHAR2
		,isDefault VARCHAR2
		--{CHILD_PARAMETERS}
    ) RETURN SELF AS RESULT
    AS
    BEGIN
		SELF.id := id;
		SELF.shortDescription := shortDescription;
		SELF.longDescription := longDescription;
		SELF.referenceDatacode := referenceDatacode;
		SELF.key01 := key01;
		SELF.key02 := key02;
		SELF.key03 := key03;
		SELF.key04 := key04;
		SELF.value01 := value01;
		SELF.value02 := value02;
		SELF.value03 := value03;
		SELF.value04 := value04;
		SELF.value05 := value05;
		SELF.value06 := value06;
		SELF.status := status;
		SELF.startDate := startDate;
		SELF.endDate := endDate;
		SELF.environment := environment;
		SELF.category := category;
		SELF.isDefault := isDefault;
		--{CHILD_BODY_PARAMETERS}
        RETURN;
    END;
*/	
END;
/
/
CREATE OR REPLACE TYPE T_REFERENCEDATA AS TABLE OF O_REFERENCEDATA
/
