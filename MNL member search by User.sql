DECLARE @User NVARCHAR(100)
SET @User = '%Smith%'

SELECT MNL.DISPLAY_NAME AS MNL, U.DISPLAY_NAME AS Member, U.USER_NAME AS UserName, U.IS_DISABLED AS UserDisabled, U.IS_INACTIVE AS UserInactive
FROM DATACENTER.MASTER_NAMES_LIST MNL
JOIN DATACENTER.MASTER_NAMES MN ON MNL.MASTER_NAMES_LIST_ID=MN.MASTER_NAMES_LIST_ID
JOIN ENGINE.USER_SETTINGS U ON MN.MASTER_NAMES=U.USER_ID
WHERE U.DISPLAY_NAME LIKE @User

SELECT MNL.MASTER_NAMES_LIST_ID as LnlID, MNL.DISPLAY_NAME AS LNL, LP.HIERARCHICAL_NAME AS Loc, U.DISPLAY_NAME AS Member, U.USER_NAME AS UserName, U.IS_DISABLED AS UserDisabled, U.IS_INACTIVE AS UserInactive
FROM DATACENTER.MASTER_NAMES_LIST MNL
LEFT JOIN DATACENTER.LOCATION_NAMES_LIST LNL ON MNL.MASTER_NAMES_LIST_ID=LNL.APP_MASTER_NAMES_LIST
LEFT JOIN DATACENTER.ETQ$LOCATION_NAMES_LIST_LOCS LOCS ON LNL.LOCATIO_NAME_LIST_ID=LOCS.LOCATIO_NAME_LIST_ID
LEFT JOIN DATACENTER.LOCATION_PROFILE LP ON LOCS.ETQ$LOCATIONS_ID=LP.LOCATION_PROFILE_ID
LEFT JOIN DATACENTER.LOCATIONS_NAMES LN ON LNL.LOCATIO_NAME_LIST_ID=LN.LOCATIO_NAME_LIST_ID
LEFT JOIN ENGINE.USER_SETTINGS U ON LN.LOCATIONS_NAMES_ID=U.USER_ID
WHERE U.DISPLAY_NAME LIKE @User
