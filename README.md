# brunch_recom
## contents recommendation

### article은 magizine에 속한다

데이터설명
[magazines_edit]
- magazine_tag_list: 해당 매거진의 태그 목록
- magazine_id: magazine 고유 식별자

[metadata_edit3]
- article_number: 기사 고유 id(author_id + article_id)
- article_keyword: 해당 글 키워드(작가가 설정)
- magazine_tag_list: 해당 글이 속한 매거진 태그목록
- title: 글 제목
- sub_title: 글 부제목
- author_id: 작가 id
- article_id: 기사 숫자
- magazine_id: 매거진 고유 식별자

[read_edit]
- raw: dt+id+article_id
- dt: 읽은 날짜
- id: 읽은 사용자 id(암호화)
- article_id: 읽은 기사 고유id(wide data)

[users_edit](wide data)
- keyword_list: 해당 사용자가 팔로잉하는 키워드리스트
- following_list: 해당 사용자가 팔로잉하는 작가리스트
- user_id: 사용자 아이디

