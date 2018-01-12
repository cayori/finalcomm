package comm.buysell;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import comm.common.dao.AbstractDAO;

@Repository("buysellDAO")
public class BuysellDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectPagingList("buysell.selectBoardList", map);
	}

	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("buysell.insertBoard", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("buysell.updateHitCnt", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("buysell.selectBoardDetail", map);
	}

	public void updateBoard(Map<String, Object> map) throws Exception{
		update("buysell.updateBoard", map);
	}

	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("buysell.deleteBoard", map);
	}

	
	
	
	// 파일 관련해서는 마지막에 전반적으로 손볼것
	public void insertFile(Map<String, Object> map) throws Exception{
		insert("buysell.insertFile", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("buysell.selectFileList", map);
	}

	public void deleteFileList(Map<String, Object> map) throws Exception{
		update("buysell.deleteFileList", map);
	}

	public void updateFile(Map<String, Object> map) throws Exception{
		update("buysell.updateFile", map);
	}

}
