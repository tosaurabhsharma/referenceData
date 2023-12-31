CREATE PROCEDURE REFERENCEDATA_PREADDUPD
(
	REFERENCEDATA		IN O_REFERENCEDATA
	,LOCALEHEADER 		IN O_LOCALEHEADER
	,REQ_REFERENCEDATA	OUT NOCOPY O_REFERENCEDATA
)
AS
V_REQ_REFERENCEDATA O_REFERENCEDATA;
--Incase there is logic to be written before inserting data in tables,then it can be written here
--When system generates this procedure,it is defined as "CREATE" only
V_CLONE_REQ_OBJECT	VARCHAR2(5) DEFAULT 'FALSE';
BEGIN
	
	--{DYNAMIC_CHECK_CONSTRAINT}
	
	--By default this section is commented - if logic is to be written to update request object,then uncomment
	
	/*
	 
	V_CLONE_REQ_OBJECT	:= 'TRUE';
		V_REQ_REFERENCEDATA  := 
	O_REFERENCEDATA
	(	
		id => REFERENCEDATA.id
		,shortDescription => REFERENCEDATA.shortDescription
		,longDescription => REFERENCEDATA.longDescription
		,referenceDatacode => REFERENCEDATA.referenceDatacode
		,key01 => REFERENCEDATA.key01
		,key02 => REFERENCEDATA.key02
		,key03 => REFERENCEDATA.key03
		,key04 => REFERENCEDATA.key04
		,value01 => REFERENCEDATA.value01
		,value02 => REFERENCEDATA.value02
		,value03 => REFERENCEDATA.value03
		,value04 => REFERENCEDATA.value04
		,value05 => REFERENCEDATA.value05
		,value06 => REFERENCEDATA.value06
		,status => REFERENCEDATA.status
		,startDate => REFERENCEDATA.startDate
		,endDate => REFERENCEDATA.endDate
		,environment => REFERENCEDATA.environment
		,category => REFERENCEDATA.category
		,isDefault => REFERENCEDATA.isDefault

	);
	*/
	--Find&Substitute/Format data as needed 
	
	IF(V_CLONE_REQ_OBJECT = 'FALSE' )THEN
		REQ_REFERENCEDATA	:= REFERENCEDATA;
	ELSE
		REQ_REFERENCEDATA	:= V_REQ_REFERENCEDATA;
	END IF;
	
	RETURN;
END;
/
CREATE PROCEDURE REFERENCEDATA_POSTADDUPD
(
	REFERENCEDATA	IN O_REFERENCEDATA
	,LOCALEHEADER 	IN O_LOCALEHEADER
	,RESPONSES_REFERENCEDATA	IN OUT NOCOPY T_REFERENCEDATA
)
AS
--Incase there is logic to be written,then it can be written here
--When system generates this procedure,it is defined as "CREATE" only
BEGIN
	
	
	--If start/end date are there,then record status will vary as start/end date
	REFERENCEDATA_STATUSADDUPD
	(
		LOCALEHEADER	=> REFERENCEDATA_POSTADDUPD.{LOCALEHEADER}	
		REFERENCEDATA	=> REFERENCEDATA_POSTADDUPD.REFERENCEDATA	
		,RESPONSES_REFERENCEDATA => REFERENCEDATA_POSTADDUPD.RESPONSES_REFERENCEDATA
	);
	
	RETURN;
END;
/

/
CREATE OR REPLACE PROCEDURE REFERENCEDATA_STATUSADDUPD
(
	LOCALEHEADER	IN O_LOCALEHEADER
	,REFERENCEDATA	IN O_REFERENCEDATA
	,RESPONSES_REFERENCEDATA	IN OUT NOCOPY T_REFERENCEDATA
)
AS
BEGIN

    IF( RESPONSES_REFERENCEDATA IS NULL )THEN
        RETURN;
    END IF;

	FOR J IN 1..RESPONSES_REFERENCEDATA.COUNT LOOP
		
		UPDATE REFERENCEDATA
		SET
		STATUS='INACTIVE'
		WHERE
		UUID
		IN
		(
			SELECT
			UUID
			FROM
			REFERENCEDATA
			WHERE
			(STARTDATE - SYSDATE ) > 0 
			AND
			UUID = RESPONSES_REFERENCEDATA(J).ID
		);
		
		
		UPDATE REFERENCEDATA
		SET
		STATUS='EXPIRED'
		WHERE
		UUID
		IN
		(
			SELECT
			UUID
			FROM
			REFERENCEDATA
			WHERE
			(ENDDATE - SYSDATE ) < 0 
			AND
			UUID = RESPONSES_REFERENCEDATA(J).ID
		);		
		
		/*EXPIRESAT
		UPDATE REFERENCEDATA
		SET
		STATUS='EXPIRED'
		WHERE
		UUID
		IN
		(
			--Search for those records which are active
			--and not in any other status
			--Example : PROMOTION_CODE - if status is REDEEMED,then it is used
			--In such cases - we dont change status to EXPIRED
			SELECT
			UUID
			FROM
			REFERENCEDATA
			WHERE
			(
				EXPIRESAT IS NULL 
				OR
				(EXPIRESAT - SYSDATE ) < 0 
			)
			AND
			UUID = RESPONSES_REFERENCEDATA(J).ID
			AND
			STATUS='ACTIVE'
		);		
		EXPIRESAT*/
    END LOOP;
	RETURN;
END;
/

/
