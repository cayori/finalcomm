package comm.review;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import comm.common.dao.AbstractDAO;

@Repository("reviewDAO")
public class ReviewDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception{
		List<Map<String, Object>> result = (List<Map<String, Object>>)selectPagingList("review.selectBoardList", map);
		return result;
	}

	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("review.insertBoard", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("review.updateHitCnt", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("review.selectBoardDetail", map);
	}

	public void updateBoard(Map<String, Object> map) throws Exception{
		update("review.updateBoard", map);
	}

	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("review.deleteBoard", map);
	}

	public List<Map<String, Object>> selectCommentList(Map<String, Object> map) throws Exception{
		List<Map<String, Object>> result = (List<Map<String, Object>>)selectPagingList("review.selectCommentList", map);
		return result;
	}
	
	
	// 파일 관련해서는 마지막에 전반적으로 손볼것
	public void insertFile(Map<String, Object> map) throws Exception{
		insert("review.insertFile", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("review.selectFileList", map);
	}

	public void deleteFileList(Map<String, Object> map) throws Exception{
		update("review.deleteFileList", map);
	}

	public void updateFile(Map<String, Object> map) throws Exception{
		update("review.updateFile", map);
	}

}
