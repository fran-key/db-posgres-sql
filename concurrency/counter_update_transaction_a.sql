-- New two psql session and type these commands in corresponding terminal.

-- Case 1: use row-level lock.
BEGIN TRANSACTION;
SELECT hits FROM web_pages WHERE page_url = 'a.com/index.html' FOR UPDATE; --It will get a row lock. If this lock is occupied by other session, the execution will be bocked here.

UPDATE web_pages SET hits = 9 WHERE page_url = 'a.com/index.html';

COMMIT; -- After commit, the row block will be released. So it is per tranaction-lock.

